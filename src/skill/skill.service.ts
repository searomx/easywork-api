import { Injectable } from '@nestjs/common';
import { CreateSkillDto } from './dto/create-skill.dto';
import { UpdateSkillDto } from './dto/update-skill.dto';
import { PrismaService } from 'src/db/prisma.service';

@Injectable()
export class SkillService {
  constructor(private readonly prismaService: PrismaService) {
    this.prismaService = prismaService;
  }
  create(createSkillDto: CreateSkillDto) {
    return this.prismaService.skill.create({
      data: createSkillDto,
    });
  }
  findAll() {
    return this.prismaService.skill.findMany();
  }

  findOne(id: number) {
    return this.prismaService.skill.findOne({
      where: { id },
    });
  }

  update(id: number, updateSkillDto: UpdateSkillDto) {
    return this.prismaService.skill.update({
      where: { id },
      data: updateSkillDto,
    });
  }

  remove(id: number) {
    return this.prismaService.skill.remove({
      where: { id },
    });
  }
}
